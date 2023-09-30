import {GraphQLEnumType} from "graphql";

const transmissionSystemType = new GraphQLEnumType({
    name: 'TransmissionSystem',
    values: {
        MANUEL: { value: 1 },
        AUTOMATIC: { value: 2 },
    },
})

export {transmissionSystemType}