'use strict'
/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database') //== Usando a lib database

class Usuario extends Model {

    ListarUsuarios( ) {
        return  database
            .raw('SELECT `usuario`.`pkUsuario`,`usuario`.`username`,`usuario`.`email`,`usuario`.`password`,`usuario`.`idUsuario`,`usuario`.`tipoUsuario`,`usuario`.`data_criacao`,`usuario`.`data_modificacao`,`usuario`.`status_` FROM `bookapp`.`usuario` limit 100;') ;
      }
}

module.exports = Usuario
