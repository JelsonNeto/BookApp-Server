'use strict'

/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| Http routes are entry points to your web application. You can create
| routes for different URL's and bind Controller actions to them.
|
| A complete guide on routing is available here.
| http://adonisjs.com/docs/4.1/routing
|
*/

/** @type {typeof import('@adonisjs/framework/src/Route/Manager')} */
const Route = use('Route')
//.middleware('RotaAutenticada')
Route.group(() => {
    //Rotas de cadastro
    Route.post('/AdicionarLivrosVenda', 'LivrosVenda/Livros_Venda.Adicionar')
    Route.post('/addLivraria' , 'Livraria/LivrariaController.Adicionar')
    Route.post('/addLivro' , 'Livraria/LivroController.Adicionar')
    Route.post('/addLeitor' , 'Leitor/LeitorController.Adicionar')
    Route.get('/searchLeitor/:elemento' , 'Leitor/LeitorController.pesquisar')
    Route.post('/login','Autenticacao/AutenticacaoController.Login')

    //Rotas de Leitura
}).prefix('api')

