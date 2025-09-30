<?php

class Cliente
{
    public $id;
    public $nome;
    public $senha;
    public $telefone;
    public $endereco;

    private $conn;

    public function __construct(PDO $conn)
    {
        $this->conn = $conn;
    }

    public function cadastrar(): bool
    {
        try {
            $sql = "INSERT INTO cliente (nome, senha, telefone, endereco) VALUES (?, ?, ?, ?)";

            $dados = [
                $this->nome,
                $this->senha,
                $this->telefone,
                $this->endereco
            ];

            $stmt = $this->conn->prepare($sql);
            $stmt->execute($dados);

            return ($stmt->rowCount() > 0);
        } catch (PDOException $e) {
            echo "Erro ao cadastrar cliente: " . $e->getMessage();
            throw new Exception("Erro ao cadastrar cliente: " . $e->getMessage());
        }
    }

    public function consultarTodos()
    {
        try {
            $sql = "SELECT * FROM cliente";
            $stmt = $this->conn->query($sql);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar clientes: " . $e->getMessage();
            throw new Exception("Erro ao consultar clientes: " . $e->getMessage());
        }
    }

    public function consultarPorId($id)
    {
        try {
            $sql = "SELECT * FROM cliente WHERE id = ?";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$id]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar cliente: " . $e->getMessage();
            throw new Exception("Erro ao consultar cliente: " . $e->getMessage());
        }
    }

    public function editar()
    {
        try {
            $sql = "UPDATE cliente SET nome = ?, senha = ?, telefone = ?, endereco = ? WHERE id = ?";

            $dados = [
                $this->nome,
                $this->senha,
                $this->telefone,
                $this->endereco,
                $this->id
            ];

            $stmt = $this->conn->prepare($sql);
            $stmt->execute($dados);

            return ($stmt->rowCount() > 0);
        } catch (PDOException $e) {
            echo "Erro ao editar cliente: " . $e->getMessage();
            throw new Exception("Erro ao editar cliente: " . $e->getMessage());
        }
    }
}
