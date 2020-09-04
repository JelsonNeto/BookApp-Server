'use strict'
/**
 * @author BookApp-Devs
 */
class RotaAuntenticada{

    async handle ({ request, response }, next) {
        let header = request.request.headers //Obtem o cabeçalho da requisição
        if(header.authorization === undefined){response.send(403);} //verifica se tem autenticação
        else{
            let Bearer = header.authorization.split(' ') //Verifica se o token não é indefinido
            if( Bearer[1] !== undefined ) { 
                request.usuario = Bearer[1] // ---Alterando a requisição para passar o pkUsuario
                //
                     //-Restante dos dados
                //
                    await next() //Passa para o proximo middleware da rota
            }else
                response.sendStatus(403);
        }
       
         
      }

}

module.exports = RotaAuntenticada