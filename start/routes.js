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

     //Rotas de usuários
     Route.get('/ListarUsuarios' , 'Usuario/UsuarioController.ListarUsuarios')
     Route.post('/user/login','Autenticacao/AutenticacaoController.Login')
     Route.post('/user/verifyPhone','Usuario/UsuarioController.userPhoneExists')
     Route.post('/user/verifyEmail','Usuario/UsuarioController.userEmailExists')
     Route.post('/user/follow','Usuario/UsuarioController.follow').middleware('RotaAutenticada')
     Route.post('/user/getFollowers','Usuario/UsuarioController.getFollowers').middleware('RotaAutenticada')
     Route.post('/user/unFollow','Usuario/UsuarioController.unFollow').middleware('RotaAutenticada')
     Route.post('/user/changeAvatar','Usuario/UsuarioController.changeAvatar').middleware('RotaAutenticada')
     Route.post('/user/avatar','Usuario/UsuarioController.avatar').middleware('RotaAutenticada')
    

    


    //Rotas de Leitor
    Route.post('/addLeitor' , 'Leitor/LeitorController.Adicionar')
    Route.get('/ListarLeitores' , 'Leitor/LeitorController.ListarLeitores').middleware('RotaAutenticada')
    Route.get('/searchLeitor/:elemento' , 'Leitor/LeitorController.pesquisar')
    Route.post('/reader/getReaderData/' , 'Leitor/LeitorController.getReaderData').middleware('RotaAutenticada')

    //Rotas Livraria
    Route.post('/addLivraria' , 'Livraria/LivrariaController.Adicionar')
    Route.get('/ListarLivrarias' , 'Livraria/LivrariaController.ListarLivrarias').middleware('RotaAutenticada')
    Route.post('/library/getLibraryData/' , 'Livraria/LivrariaController.getLibraryData').middleware('RotaAutenticada')
   


   //Rotas Livros 
    Route.post('/book/addLivro' , 'Livraria/LivroController.Adicionar').middleware('RotaAutenticada')
    Route.post('/book/AdicionarLivrosVenda', 'LivrosVenda/Livros_Venda.Adicionar')
    Route.get('/book/ListarLivros' , 'Livraria/LivroController.ListarLivros').middleware('RotaAutenticada')
    Route.get('/book/ListarLivrosAVenda' , 'LivrosVenda/Livros_Venda.ListarLivrosAVenda')


    //Rotas  publicacoes

    Route.post('/post/listPost','Post/PostController.listPost').middleware('RotaAutenticada')
    
    Route.post('/post/addPost','Post/PostController.addPost').middleware('RotaAutenticada')
    

  
  

}).prefix('api')

