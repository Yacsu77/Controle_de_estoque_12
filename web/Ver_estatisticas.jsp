<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
            String jdbcUser = "Yacsu77";
            String jdbcPassword = "pedro123@";

            Connection conn = null;
            PreparedStatement st = null;
            ResultSet rs = null;

            int caixa_aberto = 1;
            int Cod = Integer.parseInt(request.getParameter("loja"));

            try {
                // Conectar ao banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

                // Verificar se já existe um registro com cod_loja e estado = 1
                String query = "SELECT COUNT(*) AS total FROM caixa WHERE cod_loja = ? AND estado = ?";
                st = conn.prepareStatement(query);
                st.setInt(1, Cod);
                st.setInt(2, caixa_aberto);
                rs = st.executeQuery();

                if (rs.next() && rs.getInt("total") > 0) {
                    String insertQuery = "INSERT INTO caixa (estado, cod_loja) VALUES (?, ?)";
                    st = conn.prepareStatement(insertQuery);
                    st.setInt(1, caixa_aberto);
                    st.setInt(2, Cod);
                    st.executeUpdate();

                    out.print("Produto alterado com sucesso");
                    response.sendRedirect("Caixa_aberto.jsp?Cod=" + Cod );                
            
            } else {
                    // Caso contrário, inserir o registro
                    String insertQuery = "INSERT INTO caixa (estado, cod_loja) VALUES (?, ?)";
                    st = conn.prepareStatement(insertQuery);
                    st.setInt(1, caixa_aberto);
                    st.setInt(2, Cod);
                    st.executeUpdate();

                    out.print("Produto alterado com sucesso");
                    response.sendRedirect("Caixa_aberto.jsp?Cod=" + Cod );
                }
            } catch (SQLException erro) {
                out.print("Erro = " + erro.getMessage());
            } catch (ClassNotFoundException erro) {
                out.print("Erro de driver JDBC = " + erro.getMessage());
            } finally {
                // Fechar recursos
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (st != null) try { st.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
    </body>
</html>
