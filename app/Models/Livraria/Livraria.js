'use strict'
/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database') //== Usando a lib database

class Livraria extends Model {


    getLastInserted(){

        return  database
        .raw("SELECT tipoUsuario,idUsuario,livraria.telefone1,livraria.email,usuario.`pkUsuario`,usuario.`idUsuario`,usuario.`tipoUsuario` from livraria inner join usuario on livraria.`pkLivraria` = usuario.`idUsuario` order by livraria.pkLivraria desc limit 1")
    
    }


    Adicionar( dados ) {
      return  database
          .raw('call STP_LIVRARIA_INSERT_UPDATE(?,?,?,?,?,?,?,?)',dados) //Chamando a procedure
    }


  

    getLibraryData(idUsuario){
        return  database
        .raw("SELECT idUsuario,tipoUsuario ,livraria.nome,livraria.nif,livraria.endereco,livraria.email,livraria.telefone1,livraria.telefone2,usuario.status_,avatar from livraria inner join usuario on livraria.`pkLivraria` = usuario.`idUsuario`  WHERE pkLivraria = ? ",[idUsuario])
    
    }
  
    ListarLivrarias( ) {
        return  database
            .raw('SELECT `livraria`.`pkLivraria`,`livraria`.`nome`,`livraria`.`nif`,`livraria`.`endereco`,`livraria`.`email`,`livraria`.`telefone1`,`livraria`.`telefone2`,`livraria`.`data_criacao`,`livraria`.`data_modificacao`,`livraria`.`status_` FROM `bookapp`.`livraria` limit 100;') ;
      }
}

module.exports = Livraria
