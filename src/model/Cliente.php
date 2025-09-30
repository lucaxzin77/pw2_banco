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
            $sql = "CALL p_CadastrarCliente(?, ?, ?, ?)";

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
            $sql = "CALL p_ConsultarClientes()";
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
            $sql = "CALL p_ConsultarClienteByID(?)";
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
            $sql = "CALL p_EditarCliente(?, ?, ?, ?, ?)";

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

    public function delete($id)
    {
        try {
            $sql = "CALL p_DeletarCliente(?)";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$id]);

            return ($stmt->rowCount() > 0);
        } catch (PDOException $e) {
            echo "Erro ao deletar cliente: " . $e->getMessage();
            throw new Exception("Erro ao deletar cliente: " . $e->getMessage());
        }
    }
}
