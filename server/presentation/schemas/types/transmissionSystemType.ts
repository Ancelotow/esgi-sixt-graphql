import {GraphQLEnumType} from "graphql";

const transmissionSystemType = new GraphQLEnumType({
    name: 'TransmissionSystem',
    values: {
        MANUAL: { value: 1 },
        AUTOMATIC: { value: 2 },
    },
})

export {transmissionSystemType}
