'use strict'
/**
 * @author BookApp-Devs
 */
/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database')

class LivrosVenda extends Model {

    Adicionar( dados ) {
        return database.
                 raw('call STPLIVROS_VENDA_INSERT_UPDATE(?,?,?,?,?,?)', dados)
    }
}

module.exports = LivrosVenda
