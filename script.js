var formG = document.getElementById('formularioGeral');

var campo = document.getElementById('campoNome');

let registrarNome;
let registroIDA;
let registroDAT;
let registroEscola;
let registroStatus;

formG.addEventListener('submit', function(e) {
    

    registrarNome = campoNome.value;
    registrarIDA = campoIdade.value;
    registrarDAT = campoData.value;
    registrarEscola = campoEscola.value;
    registrarStatus = campoStatus.value;
    
    document.write("Nome: " + registrarNome + "<br>");
    document.write("Idade: " + registrarIDA + "<br>");
    document.write("Data: " + registrarDAT + "<br>");
    document.write("Escola: " + registrarEscola + "<br>");
    document.write("Status: " + registrarStatus + "<br>");

    e.preventDefault();
});
