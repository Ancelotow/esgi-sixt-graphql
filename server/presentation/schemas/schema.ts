import query from "./query";
import {GraphQLSchema} from "graphql";
import mutation from "./mutation";

export default new GraphQLSchema({ query: query, mutation: mutation });
