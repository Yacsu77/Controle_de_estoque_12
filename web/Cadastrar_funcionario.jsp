<%@ page import="java.sql.*" %>

<%
    // Pega os parâmetros do formulário de cadastro
    String Gerente = request.getParameter("Funcionario");
    String CPF = request.getParameter("CPF");
    String Senha = request.getParameter("Senha");
    int id = Integer.parseInt(request.getParameter("id"));
    
    String CNPJ = request.getParameter("CNPJ"); // Corrigido de "CPF" para "CNPJ"

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
        stmtVerificarCNPJ.setString(1, CNPJ);
        rs = stmtVerificarCNPJ.executeQuery();

        if (rs.next()) {
            int count = rs.getInt(1);

            if (count > 0) {
                // Se o CNPJ já existe, retorna uma mensagem de erro
                session.setAttribute("mensagem", "Este CNPJ já está cadastrado. Tente novamente.");
                response.sendRedirect("cadastro_empresa.html");
            } else {
                // Se o CNPJ não existe, insere os dados na tabela
                String sqlInserir = "INSERT INTO funcionario (nome_funcionario, cpf, senha , cod_empresa) VALUES (?, ?, ?, ?)";
                stmtInserir = conexao.prepareStatement(sqlInserir);
                stmtInserir.setString(1, Gerente);
                stmtInserir.setString(2, CPF);
                stmtInserir.setString(3, Senha);
                stmtInserir.setInt(4, id);

                int linhasAfetadas = stmtInserir.executeUpdate();

                if (linhasAfetadas > 0) {
                    response.sendRedirect("Cadastrar_gerente_form.jsp?id=" + id);
                } else {
                    session.setAttribute("mensagem", "Operação não-sucedida. Tente novamente.");
                    response.sendRedirect("Cadastrar_gerente_form.jsp");
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace(); // Exibe o erro no console
        session.setAttribute("mensagem", "Ocorreu um erro durante a operação. Tente novamente.");
        response.sendRedirect("Cadastrar_gerente_form.jsp");
    } finally {
        // Fechar recursos, como ResultSet, PreparedStatement e Connection
        try {
            if (rs != null) rs.close();
            if (stmtVerificarCNPJ != null) stmtVerificarCNPJ.close();
            if (stmtInserir != null) stmtInserir.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Exibe erro ao fechar recursos
        }
    }
%>
