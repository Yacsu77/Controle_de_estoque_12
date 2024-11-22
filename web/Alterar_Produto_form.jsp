<%@ page import="java.sql.*" %>
<%
    // Obtendo o ID da empresa do parâmetro
    int id = Integer.parseInt(request.getParameter("id"));
    int Cod = Integer.parseInt(request.getParameter("Cod"));


    // Variáveis para conexão com o banco
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    // Conectando ao banco de dados e obtendo os fornecedores
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
        
        // Consulta SQL para obter os fornecedores da empresa específica
        String sql = "SELECT * FROM fornecedor WHERE cod_empresa = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Cod);
        rs = stmt.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Produtos</title>
    <link rel="stylesheet" href="cadastro_empesa.css">
</head>
<body>
    <h2>Cadastro de Produto</h2>
    <form action="Alterar_Produtos.jsp?Cod=<%= id %>&Id_pro=<%= Cod %>"method="post">
        
        <label for="nome_produto">Nome do Produto:</label>
        <input type="text" id="nome_produto" name="nome_produto" maxlength="50" required>


        <label for="cod_forne">Fornecedor:</label>
        <select id="cod_forne" name="cod_forne" required>
            <option value="">Selecione um fornecedor</option>
            <%
                // Populando o dropdown com os fornecedores
                if (rs != null) {
                    while (rs.next()) {
                        int codForne = rs.getInt("id"); // Altere para o nome correto da coluna
                        String nomeForne = rs.getString("fornecedor"); // Altere para o nome correto da coluna
            %>
                        <option value="<%= codForne %>"><%= nomeForne %></option>
            <%
                    }
                }
            %>
        </select>

        <label for="preco">Valor Custo:</label>
        <input type="number" id="preco" name="preco" step="0.01" required>
        
        <label for="Valor_venda">Valor venda:</label>
        <input type="number" id="Valor_venda" name="Valor_venda" step="0.01" required>

        <button type="submit">Alterar Produto</button>
    </form>

    <%
        // Fechando a conexão com o banco de dados
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    %>
</body>
</html>
