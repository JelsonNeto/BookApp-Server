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
    Route.post('/login','Autenticacao/AutenticacaoController.Login')

    //Rotas de Leitura
    Route.get('/ListarLivrosAVenda' , 'LivrosVenda/Livros_Venda.ListarLivrosAVenda')
    Route.get('/ListarLivrarias' , 'Livraria/LivrariaController.ListarLivrarias')
    Route.get('/ListarLivros' , 'Livraria/LivroController.ListarLivros')
    Route.get('/ListarLeitores' , 'Leitor/LeitorController.ListarLeitores')
    Route.get('/ListarUsuarios' , 'Usuario/UsuarioController.ListarUsuarios')
    Route.get('/searchLeitor/:elemento' , 'Leitor/LeitorController.pesquisar')

}).prefix('api')

