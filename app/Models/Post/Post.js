'use strict'
/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database') //== Usando a lib database

class Post extends Model {


    addPost(dados){
        return  database
        .raw('CALL `STP_POST_INSERT_UPDATE`(?,?,?,?,?,?);',dados) ;
 
    }

    listPost( ) {
        return  database
            .raw('SELECT * FROM `bookapp`.`posts` limit 100;') ;
      }
}

module.exports = Post
