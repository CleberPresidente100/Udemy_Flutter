/****************************************************************************************************************
 *
 * PARA SE TESTAR ESTES EXEMPLOS, BASTA UTILIZAR O SITE DO DART PAD (https://dartpad.dev/?null_safety=true)
 *
****************************************************************************************************************/

// ************************************************************************************
// VARIÁVEIS
// ************************************************************************************

// DYNAMIC --> É possível declarar uma variável como possuindo um dinâmico. Ou seja, é possível atribuir a ela valores de tipos diferentes.
// Ex:

void main(){
    dynamic teste;
    teste = 1 + 1; // Tipo Inteiro.
    print(teste);
    teste = "Cleber Presidente"; // Tipo String.
    print(teste);
}



// ************************************************************************************
// FUNÇÕES
// ************************************************************************************

// *****************
// FUNÇÕES INLINE
// *****************
    void main(){
        print(calcularAreaCirculo(2));
    }

    // A seta indica o retorno da função
    double calcularAreaCirculo (int raio) => 3.14 * raio * raio;


// ******************************
// PARÂMETROS COM VALOR PADRÃO
// ******************************
// Para definir um valor padrão para os parâmetros, os mesmos precisam serem declarados entre chaves.

    void main(){
        criarBotao("Parâmetros Padrão");
        criarBotao("Parâmetros Personalizados", cor:"Verde", largura:10);
    }

    void criarBotao(String texto, {String cor = "Azul", double largura = 20}){
        print(texto);
        print(cor);
        print(largura);
    }


// ******************************
// PASSAR FUNÇÕES COMO PARÂMETROS
// ******************************
// Para se passar uma função como parâmetro, basta criar um parâmetro do tipo "Function".

    void main(){
        criarBotao("Parâmetros Padrão", exibirBotao);
        criarBotao("Parâmetros Personalizados", exibirBotao, cor:"Verde", largura:10);
    }

    void criarBotao(String texto, Function funcao, {String cor = "Azul", double largura = 20}){
        print(texto);
        print(cor);
        print(largura);
        funcao();
    }

    void exibirBotao() => print("Exibe Botão\n");


// ******************************
// FUNÇÕES ANÔNIMAS
// ******************************
// Para se criar uma função anônima, basta se abrir parênteses e logo em seguida se abrir as chaves que delimitam a função anônima.

    void main(){
        criarBotao("Parâmetros Padrão", exibirBotao);
        criarBotao("Parâmetros Personalizados", exibirBotao, cor:"Verde", largura:10);
        criarBotao("Função Anônima", (){
        print("Função Anônima executada com Sucesso !");
        });
    }

    void criarBotao(String texto, Function funcao, {String cor = "Azul", double largura = 20}){
    print(texto);
    print(cor);
    print(largura);
    funcao();
    }

    void exibirBotao() => print("Exibe Botão\n");



// ************************************************************************************
// MÉTODOS
// ************************************************************************************

// ******************************
// CONSTRUTORES
// ******************************
// Em DART, a criação de construtores é simplificada.

    void main(){
        var pessoa = Pessoa("Cleber", 41, 1.85);
    }

    class Pessoa{
    
        String nome;
        int idade;
        double altura;
        
        // Construtor tradicional.
        Pessoa(String nome, int idade, double altura){
            this.nome = nome;
            this.idade = idade;
            this.altura = altura;
        }


        // Construtor DART.
        Pessoa(this.nome, this.idade, this.altura);


        // Também é possível adicionar código dentro do construtor.
        Pessoa(this.nome, this.idade, this.altura){
            print(this.nome);
            print(this.idade);
            print(this.altura);
        }    
    }



// ******************************
// NAMED CONSTRUCTORS
// ******************************
// Em DART, é possível dar nomes para os "Overloads" dos Construtores. Ou seja, invés de apenas criar um overload do construtor, é possível "dar um nome" para esta sobrecarga.
    
    void main(){
        var pessoa = Pessoa("Cleber", 41, 1.85);
        var pessoa2 = Pessoa.nascimento("Presidente", 0.5);
    }

    class Pessoa{
    
        String nome;
        int? idade;
        double altura;


        Pessoa(this.nome, this.idade, this.altura);

        Pessoa.nascimento(this.nome, this.altura){

            this.idade = 0
            print(this.nome);
            print(this.idade);
            print(this.altura);
        }    
    }



// ******************************
// GETTERs and SETTERs
// ******************************
// Em DART, os Getters e Setters podem ser simplificados da mesma forma que as funções.
    
    void main(){        
        var pessoa = Pessoa("Cleber", 41, 1.00);
        print("A idade de " + pessoa.nome + " é " + pessoa.idade.toString() + ".");
  
        pessoa.altura = 1.85;
        print("A altura de " + pessoa.nome + " é " + pessoa.altura.toString() + ".");
        pessoa.altura = 185;
        print("A altura de " + pessoa.nome + " é " + pessoa.altura.toString() + ".");
    }

    class Pessoa{
    
        String nome;
        int _idade;
        double _altura;

        Pessoa(this.nome, this._idade, this._altura);

        int get idade => _idade;

        double get altura => _altura;

        set altura (double altura){
            if(altura > 0.0 && altura < 3.0){
                _altura = altura;
            }
        }          
    }








