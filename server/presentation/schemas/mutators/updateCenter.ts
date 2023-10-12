import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLInt, GraphQLNonNull, GraphQLString} from "graphql";
import checkIsAdmin from "../checks/checkIsAdmin";
import { centerType } from "../types/centerType";
import centerController from "../../../domain/controllers/centerController";
import UpdateCenterDto from "../../../data/models/dto/updateCenterDto";


const updateCenterType = mutationWithClientMutationId({
    name: 'UpdateCenter',
    inputFields: {
        centerId: { type: GraphQLNonNull(GraphQLInt) },
        name: { type: GraphQLString },
        address: { type: GraphQLString },
        inseeCode: { type: GraphQLString },
    },
    outputFields: {
        center: {type: centerType},
    },
    mutateAndGetPayload: async (input, context) => {
        checkIsAdmin(context); // Throw error if user is not admin

        let centerDto = new UpdateCenterDto();
        centerDto.address = input.address;
        centerDto.name = input.name;
        centerDto.insee_code = input.inseeCode;

        let centerUpdated = await centerController.update(input.centerId, centerDto);
        return {center: centerUpdated};
    },
})

export {updateCenterType};
