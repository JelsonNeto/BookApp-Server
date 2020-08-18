'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database')

class Autenticacao extends Model {

    UsuarioExistente (dados) {
       return  database.from('usuario').whereRaw('telefone = ? and password = ?', dados)
    }

}

module.exports = Autenticacao
