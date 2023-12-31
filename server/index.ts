import schema from "./presentation/schemas/schema";
import {graphqlHTTP} from "express-graphql";
import dbService from "./data/dbService";
import express = require('express');
import jwtDecoder from "./middlewares/jwtDecoder";

const app = express();

dbService.dbClient.connect()
app.use(jwtDecoder)
app.use(
    '/graphql',
    graphqlHTTP({
        schema: schema,
        graphiql: true,
    })
)
app.listen(4000)

console.log('Running a GraphQL API server at http://localhost:4000/graphql')
