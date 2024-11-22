<%@ page import="java.sql.*" %>
<%
    int secao = Integer.parseInt(request.getParameter("Sesao"));
    int Cod_loja = Integer.parseInt(request.getParameter("Cod_loja"));
    double Valor = Double.parseDouble(request.getParameter("Valor"));

    int putaria = 0;
    String cnpj = request.getParameter("CNPJ");

    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    Connection conexao = null;
    PreparedStatement stmtVerificarCNPJ = null;
    PreparedStatement stmtInserir = null;
    PreparedStatement stmtAtualizar = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexao = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Verificar se o CNPJ já existe
        String sqlVerificarCNPJ = "SELECT COUNT(*) FROM gerente WHERE cpf = ?";
        stmtVerificarCNPJ = conexao.prepareStatement(sqlVerificarCNPJ);
        stmtVerificarCNPJ.setString(1, cnpj);
        rs = stmtVerificarCNPJ.executeQuery();

        if (rs.next() && rs.getInt(1) == 0) {
            // Inserir novo registro
            String sqlInserir = "INSERT INTO Pagementos (cod_secao, cod_loja, Valor) VALUES (?, ?, ?)";
            stmtInserir = conexao.prepareStatement(sqlInserir);
            stmtInserir.setInt(1, secao);
            stmtInserir.setInt(2, Cod_loja);
            stmtInserir.setDouble(3, Valor);

            if (stmtInserir.executeUpdate() > 0) {
                out.print("Registro inserido com sucesso.");

                // Atualizar caixa
                stmtAtualizar = conexao.prepareStatement("UPDATE caixa SET estado=? WHERE Secao_caixa=?");
                stmtAtualizar.setInt(1, putaria);
                stmtAtualizar.setInt(2, secao);
                stmtAtualizar.executeUpdate();
            } else {
                out.print("Erro ao inserir registro.");
            }
        } else {
            out.print("Este CNPJ já está cadastrado.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Erro: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (stmtVerificarCNPJ != null) stmtVerificarCNPJ.close();
        if (stmtInserir != null) stmtInserir.close();
        if (stmtAtualizar != null) stmtAtualizar.close();
        if (conexao != null) conexao.close();
    }
%>
