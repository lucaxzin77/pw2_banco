<?php 

class P_Juridica {
    public $razao_social;
    public $fundacao;
    public $nome_fantasia;
    public $cnpj;
    public Cliente $cliente_id;

    private $conn;

    public function __construct(PDO $conn)
    {
        $this->conn = $conn;
    }

    public function cadastrar(): bool
    {
        try {
            $sql = "CALL p_CadastrarPJuridica(?, ?, ?, ?, ?)";

            $dados = [
                $this->razao_social,
                $this->fundacao,
                $this->nome_fantasia,
                $this->cnpj,
                $this->cliente_id
            ];

            $stmt = $this->conn->prepare($sql);
            $stmt->execute($dados);

            return ($stmt->rowCount() > 0);
        } catch (PDOException $e) {
            echo "Erro ao cadastrar pessoa jurídica: " . $e->getMessage();
            throw new Exception("Erro ao cadastrar pessoa jurídica: " . $e->getMessage());
        }
    }

    public function consultarTodos()
    {
        try {
            $sql = "CALL p_ConsultarPJuridica()";
            $stmt = $this->conn->query($sql);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar pessoas jurídicas: " . $e->getMessage();
            throw new Exception("Erro ao consultar pessoas jurídicas: " . $e->getMessage());
        }
    }

    public function consultarPorCNPJ($cnpj)
    {
        try {
            $sql = "CALL p_ConsultarPJuridicaByCNPJ(?)";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$cnpj]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar pessoa jurídica: " . $e->getMessage();
            throw new Exception("Erro ao consultar pessoa jurídica: " . $e->getMessage());
        }
    }
}
