import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLNonNull, GraphQLString} from "graphql";
import checkIsAdmin from "../checks/checkIsAdmin";
import { centerType } from "../types/centerType";
import AddCenterDto from "../../../data/models/dto/addCenterDto";
import centerController from "../../../domain/controllers/centerController";


const addCenterType = mutationWithClientMutationId({
    name: 'AddCenter',
    inputFields: {
        name: { type: GraphQLNonNull(GraphQLString) },
        address: { type: GraphQLNonNull(GraphQLString) },
        inseeCode: { type: GraphQLNonNull(GraphQLString) },
    },
    outputFields: {
        center: {type: centerType},
    },
    mutateAndGetPayload: async (input, context) => {
        checkIsAdmin(context); // Throw error if user is not admin

        let addCenterDto = new AddCenterDto();
        addCenterDto.name = input.name;
        addCenterDto.address = input.address;
        addCenterDto.insee_code = input.inseeCode;

        let centerAdded = await centerController.add(addCenterDto);
        return {center: centerAdded};
    },
})

export {addCenterType};
