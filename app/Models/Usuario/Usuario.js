'use strict'
/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database') //== Usando a lib database

class Usuario extends Model {


    changeAvatar(dados){
        return  database
        .raw('call `STPCHANGE_AVATAR`(?,?,?)',dados) ;
 
    }
    follow(dados){
        return  database
        .raw('call `STPSEGUIDOR_INSERT_UPDATE`(?,?,?,?) ',dados) ;
 
    }

    unFollow(id_seguidor){
        return  database
        .raw('DELETE FROM seguidores WHERE id_seguidor = ?',[id_seguidor]) ;
 
    }

     getFollowers(idUsuario){
        return  database
        .raw('SELECT * FROM seguidores WHERE id_seguindo = ?',[idUsuario]) ;
 
    }

    userPhoneExists(phone){

        return  database
        .raw('SELECT count(*) as qtdPhone from usuario where telefone = ?',[phone]) ;
 
    }

    userEmailExists(email){

        return  database
        .raw('SELECT count(*) as qtdEmail from usuario where email = ?',[email]) ;

    }

    ListarUsuarios( ) {
        return  database
            .raw('SELECT `usuario`.`pkUsuario`,`usuario`.`username`,`usuario`.`email`,`usuario`.`password`,`usuario`.`idUsuario`,`usuario`.`tipoUsuario`,`usuario`.`data_criacao`,`usuario`.`data_modificacao`,`usuario`.`status_` FROM `bookapp`.`usuario` limit 100;') ;
      }
}

module.exports = Usuario
