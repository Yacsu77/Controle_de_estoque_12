<%@ page import="java.sql.*" %>
<%
    // Obtendo o ID da empresa do parâmetro
    int id = Integer.parseInt(request.getParameter("id"));

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
        String sql = "SELECT * FROM produto WHERE cod_empresa = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
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
    <title>Cadastro de Produto</title>
    <link rel="stylesheet" href="cadastro_empesa.css">
</head>
<body>
    <h2>Inserir Produto Estoque</h2>
    <form action="Inserir_produto_estoque.jsp?id=<%= id %>" method="post">

        <label for="produto">Produto</label>
        <select id="produto" name="produto" required>
            <option value="">Selecione um Produto</option>
            <%
                // Populando o dropdown com os fornecedores
                if (rs != null) {
                    while (rs.next()) {
                        int codpro = rs.getInt("id"); // Altere para o nome correto da coluna
                        String nomepro = rs.getString("nome_produto"); // Altere para o nome correto da coluna
            %>
                        <option value="<%= codpro %>"><%= nomepro %></option>
            <%
                    }
                }
            %>
        </select>

        <label for="Fabrica">Data Fabricação</label>
        <input type="date" id="Fabrica" name="Fabrica" step="0.01" required>
        
        <label for="Validade">Data Validade</label>
        <input type="date" id="Validade" name="Validade" step="0.01" required>
        
        <label for="quantidade">Data Quantidade</label>
        <input type="number" id="quantidade" name="quantidade" step="0.01" required>
        
     <%   
        try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
        
        // Consulta SQL para obter os fornecedores da empresa específica
        String sql = "SELECT * FROM loja WHERE cod_empresa = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        rs = stmt.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
    
            <label for="loja">Loja</label>
        <select id="loja" name="loja" required>
            <option value="">Selecione o estoque da loja</option>
            <%
                // Populando o dropdown com os fornecedores
                if (rs != null) {
                    while (rs.next()) {
                        int codloja = rs.getInt("id"); // Altere para o nome correto da coluna
                        String nomeloja = rs.getString("nome_loja"); // Altere para o nome correto da coluna
            %>
                        <option value="<%= codloja %>"><%= nomeloja %></option>
            <%
                    }
                }
            %>
        </select>

    
    
    

        <button type="submit">Inserir Produto</button>
    </form>

    <%
        // Fechando a conexão com o banco de dados
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    %>
</body>
</html>
