import Color from "../entities/color";

interface ColorRepository {
    getAll(): Promise<Color[]>;
}

export default ColorRepository;
