import {GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Center from "../../../domain/entities/center";
import {townType} from "./townType";
import TownController from "../../../domain/controllers/townController";

const centerType = new GraphQLObjectType<Center>({
    name: 'Center',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        name: { type: GraphQLNonNull(GraphQLString) },
        address: { type: GraphQLNonNull(GraphQLString) },
        town: {
            type: GraphQLNonNull(townType),
            resolve: (center) => TownController.getByCode(center.inseeCode)
        }
    },
});

export {centerType}
