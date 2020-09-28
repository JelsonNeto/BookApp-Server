"use strict";
/**autor : BookApp-Devs */
const Post = use("App/Models/Post/Post");
const PostModel = new Post();
const toJson = use("App/Helpers/Json");
const crypto = require("crypto");
const Helpers = use("Helpers");



class PostController {
  /**
   *
   * @param {*} param0
   */

  async listPost({ response, request }) {
    let result = await PostModel.listPost(); //inserindo os dados
    let formatoJson = toJson.Create(result);
    response.json(formatoJson);
  }


  async addPost({ response, request }) {
    let errorResponse = toJson.generate(204, "error", "Could not post ", {});

    try {


      let idUsuario = request.user.id

      let {pkPosts,title,content,username} = request.body

      const postImage = request.file("image", {
        types: ["image"],
        size: "2mb",
      });

      const { extname } = postImage;


      const str = `post_${idUsuario}`;

      const name = crypto.createHash("md5").update(String(str)).digest("hex");

      const imgName = `${name}.jpg`;
      await postImage.move(Helpers.tmpPath("uploads/posts"), {
        name: imgName,
        overwrite: true,
      });


      if (!postImage.moved()) {
        let error = postImage.error();

        console.log({ ERROR: error });
        errorResponse.message = "Error during change avatar";
        errorResponse.code = 204;
        return response.json(errorResponse);
      }



     let dados = [pkPosts,title,content,imgName ,username,idUsuario]
     let result = await PostModel.addPost(dados) //inserindo os dados

     if (result[0].affectedRows > 0) {


       console.log(result[0]);

       let successResponse = toJson.generate(201, "success", "Posted", {})

       return response.status(201).json(successResponse);

     }


     console.log(result[0]);
     return response.status(400).json(errorResponse);
      
    
    } catch (error) {
      console.log({ ERROR: error });
      errorResponse.message = "Server error";
      errorResponse.code = 500;
      return response.json(errorResponse);
    }
  }

}

module.exports = PostController;
