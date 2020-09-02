'use strict'
/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database') //== Usando a lib database

class Livraria extends Model {

    Adicionar( dados ) {
      return  database
          .raw('call STP_LIVRARIA_INSERT_UPDATE(?,?,?,?,?,?,?,?,?)',dados) //Chamando a procedure
    }
  
    ListarLivrarias( ) {
        return  database
            .raw('SELECT `livraria`.`pkLivraria`,`livraria`.`nome`,`livraria`.`nif`,`livraria`.`endereco`,`livraria`.`email`,`livraria`.`telefone1`,`livraria`.`telefone2`,`livraria`.`data_criacao`,`livraria`.`data_modificacao`,`livraria`.`status_` FROM `bookapp`.`livraria` limit 100;') ;
      }
}

module.exports = Livraria
