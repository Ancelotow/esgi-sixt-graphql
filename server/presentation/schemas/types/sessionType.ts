import {GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Brand from "../../../domain/entities/brand";
import {userType} from "./userType";

const sessionType = new GraphQLObjectType<Brand>({
    name: 'Session',
    fields: {
        token: { type: GraphQLNonNull(GraphQLString) },
        user: { type: GraphQLNonNull(userType) },
    },
});

export {sessionType}
