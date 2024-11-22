<!DOCTYPE html>
<% 
int id = Integer.parseInt(request.getParameter("id"));
%>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Melhorado</title>
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', Arial, sans-serif;
            background: linear-gradient(to bottom, #4facfe, #00f2fe);
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Adiciona espaço entre os elementos */
            align-items: center;
            min-height: 100vh;
            text-align: center;
        }

        h2 {
            margin: 20px 0;
            font-size: 2rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            gap: 20px;
            padding: 40px;
            background: rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        .menu {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
        }

        .menu a {
            text-decoration: none;
            background: #fff;
            color: #333;
            border-radius: 12px;
            padding: 15px 30px;
            font-size: 1rem;
            font-weight: bold;
            text-transform: uppercase;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .menu a:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }

        .menu .gestao { background: #ff6b6b; color: white; }
        .menu .caixa { background: #ffdd57; color: white; }
        .menu .estatisticas { background: #4cd3c2; color: white; }
        .menu .estoque { background: #333; color: white; }

        .banner {
            width: 100%;
            margin-top: auto; /* Garante que o banner fique na parte inferior */
        }

        @media (max-width: 768px) {
            h2 {
                font-size: 1.5rem;
            }

            .menu a {
                padding: 10px 20px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Bem vindo <%= request.getParameter("nome_empresa") %></h2>
        <div class="menu">
            <a href="tela_gerente.jsp?id=<%= id %>" class="gestao">Gestão</a>
            <a href="Caixa.jsp?Cod=<%= id %>" class="caixa">Caixa</a>
            <a href="Vercaixa_form.jsp?Cod=<%= id %>" class="estatisticas">Estatísticas</a>
            <a href="Estoque.jsp?id=<%= id %>" class="estoque">Estoque</a>
        </div>
    </div>
    <img
        class="banner"
        src="https://capsule-render.vercel.app/api?type=waving&height=150&color=9164F5&reversal=false&section=footer"
        alt="Banner"
    />
</body>
</html>
