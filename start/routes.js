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
    Route.post('/addLivraria' , 'Livraria/LivrariaController.Adicionar')
    Route.get('/addLeitor' , 'Leitor/LeitorController.Adicionar')
    /**
     * @params: telefone,senha
     * @returns o token
     */
    Route.post('/login','Autenticacao/AutenticacaoController.Login') 
}).prefix('api')

