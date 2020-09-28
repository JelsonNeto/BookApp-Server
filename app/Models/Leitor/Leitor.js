'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database') //== Usando a lib database
class Leitor extends Model {



   
    Adicionar( dados ) {
        return  database
            .raw('call STP_Leitor_INSERT_UPDATE(?,?,?,?,?,?,?,?)',dados) //Chamando a procedure
      }   
      
      getLastInserted(){
        return  database
        .raw("SELECT leitor.telefone1,leitor.email,usuario.`pkUsuario`,usuario.`idUsuario`,usuario.`tipoUsuario` from leitor inner join usuario on leitor.`pkLeitor` = usuario.`idUsuario` order by leitor.pkLeitor desc limit 1")
    
    }

    getReaderData(idUsuario){
        return  database
        .raw("SELECT * FROM leitor WHERE leitor.pkLeitor = ? ",[idUsuario])
    
    }

      pesquisar( dados ) {
        return  database
            .raw('call STP_Pesquisar_Leitor(?)',dados) //Chamando a procedure
      }    

      ListarLeitores() {
        return  database
            .raw('SELECT `leitor`.`pkLeitor`,`leitor`.`nome`,`leitor`.`bi`,`leitor`.`endereco`,`leitor`.`telefone1`,`leitor`.`telefone2`,`leitor`.`email`,`leitor`.`data_criacao`,`leitor`.`data_modificacao`,`leitor`.`status_` FROM `bookapp`.`leitor` limit 100;') 
      } 
}

module.exports = Leitor

