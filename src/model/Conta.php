<?php

class Conta
{
    public $numero;
    public $tipo;
    public $saldo;
    public Cliente $cliente_id;

    private $conn;

    public function __construct(PDO $conn)
    {
        $this->conn = $conn;
    }

    public function cadastrar(): bool
    {
        try {
            $sql = "INSERT INTO conta (numero, tipo, saldo, cliente_id) VALUES (?, ?, ?, ?)";

            $dados = [
                $this->numero,
                $this->tipo,
                $this->saldo,
                $this->cliente_id
            ];

            $stmt = $this->conn->prepare($sql);
            $stmt->execute($dados);

            return ($stmt->rowCount() > 0);
        } catch (PDOException $e) {
            echo "Erro ao cadastrar conta: " . $e->getMessage();
            throw new Exception("Erro ao cadastrar conta: " . $e->getMessage());
        }
    }

    public function consultarTodos()
    {
        try {
            $sql = "SELECT * FROM conta";
            $stmt = $this->conn->query($sql);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar contas: " . $e->getMessage();
            throw new Exception("Erro ao consultar contas: " . $e->getMessage());
        }
    }

    public function consultarPorNumero($numero)
    {
        try {
            $sql = "SELECT * FROM conta WHERE numero = ?";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$numero]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo "Erro ao consultar conta: " . $e->getMessage();
            throw new Exception("Erro ao consultar conta: " . $e->getMessage());
        }
    }

    public function sacar($valor): bool
    {
        try {
            if ($this->saldo >= $valor) {

                $this->saldo -= ($valor * 1.05);

                $sql = "UPDATE conta SET saldo = ? WHERE numero = ?";
                $stmt = $this->conn->prepare($sql);
                $stmt->execute([$this->saldo, $this->numero]);
                return ($stmt->rowCount() > 0);
            } else {
                throw new Exception("Saldo insuficiente.");
            }
        } catch (PDOException $e) {
            echo "Erro ao sacar: " . $e->getMessage();
            throw new Exception("Erro ao sacar: " . $e->getMessage());
        }
    }

    public function depositar($valor): bool
    {
        try {
            $this->saldo += $valor;
            $sql = "UPDATE conta SET saldo = ? WHERE numero = ?";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$this->saldo, $this->numero]);
            return ($stmt->rowCount() > 0);
        } catch (PDOException $e) {
            echo "Erro ao depositar: " . $e->getMessage();
            throw new Exception("Erro ao depositar: " . $e->getMessage());
        }
    }

    public function transferir($valor, Conta $contaDestino): bool
    {
        try {
            if ($this->saldo >= $valor) {
                $this->sacar($valor);
                $contaDestino->depositar($valor);
                return true;
            } else {
                throw new Exception("Saldo insuficiente para transferência.");
            }
        } catch (Exception $e) {
            echo "Erro ao transferir: " . $e->getMessage();
            throw new Exception("Erro ao transferir: " . $e->getMessage());
        }
    }
}
