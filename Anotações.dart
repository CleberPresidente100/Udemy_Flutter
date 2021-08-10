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
// FOREACH
// ************************************************************************************
// Em DART, o foreach é feito da seguinte forma :

    void main(){
        
        List<int> numeros = [1, 2, 3, 4, 5];
        int resultado = 1;

        for(var x in numeros){
            resultado *= x;
        }
      
        print(resultado);
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
// ORIENTAÇÃO A OBJETOS
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
        print("${pessoa.nome} tem ${pessoa.idade} anos e ${pessoa.altura}m de altura.");
  
        pessoa.altura = 1.85;
        print("A altura de ${pessoa.nome} é ${pessoa.altura}m.");
        pessoa.altura = 185;
        print("A altura de ${pessoa.nome} é ${pessoa.altura}m.");
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



// ******************************
// HERANÇA
// ******************************
// Em DART, a herança é realizada através do comando "extends".
// A chamada do construtor da classe mãe é feito através do comando super()

    void main(){
      
        var cachorro = Cachorro("Dog", 10.0, 100);
        cachorro.comer();
        cachorro.fazerSom();
        cachorro.brincar();
        
        var gato = Gato("Cat", 2.0, true);
        gato.comer();
        gato.fazerSom();
        gato.estaAmigavel();
    }

    class Animal{
    
        String nome;
        double peso;

        Animal(this.nome, this.peso);
      
        void comer(){
          print("$nome comeu !");
        }
      
        void fazerSom(){
          print("$nome fez algum som !");
        }
    }

    class Cachorro extends Animal{
        
        int fofura;
        
        Cachorro(String nome, double peso, this.fofura) : super(nome, peso);
        
        void brincar(){
            this.fofura += 10;
            print("Nível de fofura do ${nome} : ${this.fofura}");
        }
    }

    class Gato extends Animal{
        
        bool humor;
        
        Gato(String nome, double peso, this.humor) : super(nome, peso);
        
        void estaAmigavel() => print("O gato está amigável ? ${this.humor ? "Sim" : "Não"}");
    }



// ******************************
// OVERRIDE
// ******************************
// Em DART, é possível se sobrescrever um método da classe mãe através do comando "@override".

    void main(){
      
      var cachorro = Cachorro("Dog", 10.0, 100);
      print(cachorro);
      cachorro.comer();
      cachorro.fazerSom();
      cachorro.brincar();
      
      var gato = Gato("Cat", 2.0, true);
      print(gato);
      gato.comer();
      gato.fazerSom();
      gato.estaAmigavel();
    }

    class Animal{
    
        String nome;
        double peso;

        Animal(this.nome, this.peso);
      
        void comer(){
          print("$nome comeu !");
        }
      
        void fazerSom(){
          print("$nome fez algum som !");
        }
    }

    class Cachorro extends Animal{
      
        int fofura;
      
        Cachorro(String nome, double peso, this.fofura) : super(nome, peso);
      
        void brincar(){
            this.fofura += 10;
            print("Nível de fofura do ${nome} : ${this.fofura}");
        }
      
        @override     
        void fazerSom(){
            print("$nome fez Au! Au!");
        }
      
        @override
        String toString(){
            return "O nome do cachorro é $nome.";
        }
    }

    class Gato extends Animal{
      
        bool humor;
      
        Gato(String nome, double peso, this.humor) : super(nome, peso);
      
        void estaAmigavel() => print("O gato está amigável ? ${this.humor ? "Sim" : "Não"}");
      
        @override     
        void fazerSom(){
            print("$nome fez Miau !");
        }
      
        @override
        String toString(){
            return "O nome do gato é $nome.";
        }
    }

