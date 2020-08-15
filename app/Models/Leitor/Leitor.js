'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database') //== Usando a lib database
class Leitor extends Model {
    Adicionar( dados ) {
        return  database
            .raw('call STP_Leitor_INSERT_UPDATE(?,?,?,?,?,?,?,?)',dados) //Chamando a procedure
      }    
}

module.exports = Leitor
