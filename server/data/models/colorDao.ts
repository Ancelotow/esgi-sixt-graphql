import Color from "../../domain/entities/color";

class ColorDao {
    constructor(
        public id: number,
        public name: string,
        public hex: string
    ) { }

    toEntity() {
        let color = new Color()
        color.id = this.id
        color.name = this.name
        color.hex = this.hex
        return color
    }
}

export default ColorDao
