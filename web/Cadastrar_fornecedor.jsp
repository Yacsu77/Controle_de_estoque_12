<%@ page import="java.sql.*" %>

<%
    // Pega os parâmetros do formulário de cadastro
    String nomefornecedor = request.getParameter("Fornecedor");
    String cnpj = request.getParameter("cnpj");
    int cod_empresa = Integer.parseInt(request.getParameter("id"));

    // Conexão com o banco de dados
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    Connection conexao = null;
    PreparedStatement stmtVerificarCNPJ = null;
    ResultSet rs = null;
    PreparedStatement stmtInserir = null;

    try {
        // Carrega o driver JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Estabelece a conexão com o banco de dados
        conexao = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Verifica se o CNPJ já existe no banco
        String sqlVerificarCNPJ = "SELECT COUNT(*) FROM fornecedor WHERE CNPJ = ?";
        stmtVerificarCNPJ = conexao.prepareStatement(sqlVerificarCNPJ);
        stmtVerificarCNPJ.setString(1, cnpj);
        rs = stmtVerificarCNPJ.executeQuery();

        if (rs.next()) {
            int count = rs.getInt(1);

            if (count > 0) {
                // Se o CNPJ já existe, retorna uma mensagem de erro
                session.setAttribute("mensagem", "Este CNPJ já está cadastrado. Tente novamente.");
                response.sendRedirect("cadastro_empresa.html");
            } else {
                // Se o CNPJ não existe, insere os dados na tabela
                String sqlInserir = "INSERT INTO fornecedor (Fornecedor, CNPJ, cod_empresa) VALUES (?, ?, ?)";
                stmtInserir = conexao.prepareStatement(sqlInserir);
                stmtInserir.setString(1, nomefornecedor);
                stmtInserir.setString(2, cnpj);
                stmtInserir.setInt(3, cod_empresa);

                int linhasAfetadas = stmtInserir.executeUpdate();

                if (linhasAfetadas > 0) {
        response.sendRedirect("Cadastar_fornecedor_form.jsp?id=" + cod_empresa);
                } else {
                    session.setAttribute("mensagem", "Operação não-sucedida. Tente novamente.");
                    response.sendRedirect("Cadastro_fornecedor_form.jsp");
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Erro: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmtVerificarCNPJ != null) stmtVerificarCNPJ.close();
            if (stmtInserir != null) stmtInserir.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
