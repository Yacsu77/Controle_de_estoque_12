<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Caixa de Produtos</title>
    <link rel="stylesheet" href="Caixa_aberto.css">
</head>
<body>
    <div class="container">
        <!-- Menu de seleção à esquerda -->
        <div class="left-panel">
            <h2>Selecione os Produtos</h2>
            <div class="product-buttons">
                <%
                    int Cod = Integer.parseInt(request.getParameter("Cod"));
                    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
                    String jdbcUser = "Yacsu77";
                    String jdbcPassword = "pedro123@";
                    Connection conecta;
                    PreparedStatement st;
                    ResultSet resultado;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

                    st = conecta.prepareStatement("Select * from caixa where cod_loja = ? ");
                    st.setInt(1, Cod);
                    resultado = st.executeQuery();
                    
                    // Verifica se o resultado contém dados antes de tentar acessar
                    int sesao = -1;
                    if (resultado.next()) {
                        sesao = resultado.getInt("Secao_caixa"); // Agora é seguro acessar
                    }

                    st = conecta.prepareStatement( "SELECT p.id, p.nome_produto, COUNT(e.Cod_Produto) as Quantidade, e.Data_fabricação, e.Data_validade, l.nome_loja, p.Valor_venda " +
                        "FROM Estoque e " +
                        "JOIN Produto p ON e.Cod_Produto = p.id " +
                        "JOIN loja l ON e.Cod_loja = l.id " +
                        "WHERE e.Cod_loja = ? " +
                        "GROUP BY p.id, p.nome_produto, e.Data_fabricação, e.Data_validade, l.nome_loja, p.Valor_venda"
                    );
                    
                    st.setInt(1, Cod);
                    resultado = st.executeQuery();

                    while (resultado.next()) {
                        int produtoId = resultado.getInt("id"); // Pegando o id do produto
                        String produtoNome = resultado.getString("nome_produto");
                        double valorVenda = resultado.getDouble("Valor_venda"); // Pegando o valor de venda
                        
                        // Adiciona os parâmetros produtoId, sesao, valorVenda e Cod na URL para redirecionamento
                        out.print("<a href=\"inserir_produto_para_venda.jsp?produto=" + produtoId + "&sesao=" + sesao + "&valorVenda=" + valorVenda + "&Cod=" + Cod + "\">" +
                                  "<button>" + produtoNome + "</button>" +
                                  "</a>");
                    }
                %>
                 <li><a href="index.html"><button class="menu-btn logout-btn">Sair</button></a></li>
            </div>
        </div>
     

        <!-- Iframe à direita -->
        <div class="right-panel">
            <iframe id="produtoIframe" src="Listar_produtos_para_pagar.jsp?Cod=<%= sesao %>" title="Produtos Adicionados"></iframe>
            <iframe id="produtoIframe" src="Valor_pagar.jsp?Cod=<%= sesao %>&Loja=<%= Cod %>" title="Produtos Adicionados"></iframe>
        </div>
     
    </div>
</body>
</html>
