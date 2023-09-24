import schema from "./presentation/schemas/schema";
import {graphqlHTTP} from "express-graphql";
import dbService from "./data/dbService";
import express = require('express');

const app = express();

dbService.dbClient.connect()

app.use(
    '/graphql',
    graphqlHTTP({
        schema: schema,
        graphiql: true,
    })
)
app.listen(4000)
console.log('Running a GraphQL API server at localhost:4000/graphql')
