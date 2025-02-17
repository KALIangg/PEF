const servicos = [
    { id: 1, nome: "Fazemos suas Lições de Casa", preco: 5.00 },
    { id: 2, nome: "Criação de Slides", preco: 4.00 },
    { id: 3, nome: "Revisão de Textos", preco: 2.50 }
];

localStorage.setItem("servicos", JSON.stringify(servicos));

function adicionarAoCarrinho(id) {
    let carrinho = JSON.parse(localStorage.getItem("carrinho")) || [];
    let item = servicos.find(servico => servico.id === id);
    carrinho.push(item);
    localStorage.setItem("carrinho", JSON.stringify(carrinho));
}
