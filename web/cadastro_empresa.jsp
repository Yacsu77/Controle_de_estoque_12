<%@ page import="java.sql.*" %>





<%
    // Pega os parâmetros do formulário de cadastro
    String nomeEmpresa = request.getParameter("company-name");
    String cnpj = request.getParameter("cnpj");
    String endereco = request.getParameter("address");
    String telefone = request.getParameter("phone");
    String email = request.getParameter("email");
    String senha = request.getParameter("Senha");

    // Conexão com o banco de dados
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Verifica se o e-mail já existe no banco
        String verificarEmailSQL = "SELECT COUNT(*) FROM empresas WHERE email = ?";
        PreparedStatement stmtVerificarEmail = conexao.prepareStatement(verificarEmailSQL);
        stmtVerificarEmail.setString(1, email);
        ResultSet rs = stmtVerificarEmail.executeQuery();

        rs.next(); // Move para o primeiro (e único) resultado
        int count = rs.getInt(1);

        if (count > 0) {
            // Se o e-mail já existe, retorna uma mensagem de erro
            session.setAttribute("mensagem", "Este e-mail já está cadastrado. Tente novamente.");
            response.sendRedirect("cadastro_empresa.html");
        } else {
            // Se o e-mail não existe, insere os dados na tabela
            String sql = "INSERT INTO empresas (nome_empresa, cnpj, endereco, telefone, email, senha) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setString(1, nomeEmpresa);
            stmt.setString(2, cnpj);
            stmt.setString(3, endereco);
            stmt.setString(4, telefone);
            stmt.setString(5, email);
            stmt.setString(6, senha);

            int linhasAfetadas = stmt.executeUpdate();

            if (linhasAfetadas > 0) {
                response.sendRedirect("Login_empresa.html");
            } else {
                session.setAttribute("mensagem", "Operação não-sucedida. Tente novamente.");
                response.sendRedirect("cadastro_empresa.html");
            }

            stmt.close();
        }

        stmtVerificarEmail.close();
        conexao.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Erro: " + e.getMessage());
    }
%>
