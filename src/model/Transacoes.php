<?php

class Transacoes
{
    public $id;
    public $tipo;
    public $valor;
    public $data;
    public $descricao;
    public Conta $conta_num;

    private $conn;

    public function __construct(PDO $conn)
    {
        $this->conn = $conn;
    }

    public function registrar(): bool
    {
        try {
            $sql = "CALL p_RegistrarTransacao(?, ?, ?, ?)";
            $dados = [
                $this->tipo,
                $this->valor,
                $this->descricao,
                $this->conta_num
            ];

            $stmt = $this->conn->prepare($sql);
            $stmt->execute($dados);
            return ($stmt->rowCount() > 0);
        } catch (PDOException $e) {
            echo "Erro ao registrar transação: " . $e->getMessage();
            throw new Exception("Erro ao registrar transação: " . $e->getMessage());
        }
    }

    public function consultarTodos(){
        try {
            $sql = "CALL p_ConsultarTransacoes()";
            $stmt = $this->conn->prepare($sql);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar transações: " . $e->getMessage();
            throw new Exception("Erro ao consultar transações: " . $e->getMessage());
        }
    }

    public function consultarPorConta($conta_num)
    {
        try {
            $sql = "CALL p_ConsultarTransacoesByConta(?)";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$conta_num]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar transações: " . $e->getMessage();
            throw new Exception("Erro ao consultar transações: " . $e->getMessage());
        }
    }
}
