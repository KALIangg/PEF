document.addEventListener("DOMContentLoaded", function () {
    let servicos = JSON.parse(localStorage.getItem("servicos")) || [];
    let container = document.getElementById("servicos");

    servicos.forEach(servico => {
        let div = document.createElement("div");
        div.className = "bg-white p-4 rounded shadow";
        div.innerHTML = `
            <h3 class="font-semibold">${servico.nome}</h3>
            <p class="text-gray-700">R$ ${servico.preco.toFixed(2)}</p>
            <button class="bg-blue-600 text-white px-4 py-2 rounded mt-2" onclick="adicionarAoCarrinho(${servico.id})">Adicionar</button>
        `;
        container.appendChild(div);
    });
});
