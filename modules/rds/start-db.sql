CREATE DATABASE pedidos;
CREATE USER pedidos_user@'%' IDENTIFIED BY 'pedidos_password';
GRANT ALL PRIVILEGES ON pedidos.* TO pedidos_user@'%';

CREATE DATABASE pagamentos;
CREATE USER pagamentos_user@'%' IDENTIFIED BY 'pagamentos_password';
GRANT ALL PRIVILEGES ON pagamentos.* TO pagamentos_user@'%';

FLUSH PRIVILEGES;