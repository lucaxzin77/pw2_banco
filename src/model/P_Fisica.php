<?php

class P_Fisica
{
    public $data_nasc;
    public $sexo;
    public $cpf;
    public $nome;
    public Cliente $cliente_id;

    private $conn;

    public function __construct(PDO $conn)
    {
        $this->conn = $conn;
    }

    public function cadastrar(): bool
    {
        try {
            $sql = "CALL p_CadastrarPFisica(?, ?, ?, ?, ?)";

            $dados = [
                $this->data_nasc,
                $this->sexo,
                $this->cpf,
                $this->nome,
                $this->cliente_id
            ];

            $stmt = $this->conn->prepare($sql);
            $stmt->execute($dados);

            return ($stmt->rowCount() > 0);
        } catch (PDOException $e) {
            echo "Erro ao cadastrar pessoa física: " . $e->getMessage();
            throw new Exception("Erro ao cadastrar pessoa física: " . $e->getMessage());
        }
    }

    public function consultarTodos()
    {
        try {
            $sql = "CALL p_ConsultarPFisica()";
            $stmt = $this->conn->query($sql);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar pessoas físicas: " . $e->getMessage();
            throw new Exception("Erro ao consultar pessoas físicas: " . $e->getMessage());
        }
    }

    public function consultarPorCPF($cpf)
    {
        try {
            $sql = "CALL p_ConsultarPFisicaByCPF(?)";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$cpf]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar pessoa física: " . $e->getMessage();
            throw new Exception("Erro ao consultar pessoa física: " . $e->getMessage());
        }
    }
}
