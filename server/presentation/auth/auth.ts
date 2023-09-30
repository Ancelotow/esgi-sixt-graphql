import express = require('express');
import UserController from "../../domain/controllers/userController";

const routerAuth = express.Router()
const controller = UserController


routerAuth.get('/login', (req, res) => {
    let user = UserController.getFromCredential(req.body.email, req.body.password);
    if (user) {
        // TODO: Générer un token JWT
    }
    res.status(401).send('Les identifiants de connexion sont incorrects');
});