export interface MoonInfo {
  Error: number;
  ErrorMsg: string;
  TargetDate: string;
  Moon: string[];
  Index: number;
  Age: number;
  Phase: string;
  Distance: number;
  Illumination: number;
  AngularDiameter: number;
  DistanceToSun: number;
  SunAngularDiameter: number;
}

export interface Moon {
  date: Date;
  img: string;
  age: number;
  phase: string;
  percent: number;
}

const getMoonImageURL = (index: number) =>
  `http://www.farmsense.net/demos/images/moonphases/${index}.png`;

export const convert = ({
  TargetDate,
  Index,
  Age,
  Phase,
  Illumination,
}: MoonInfo) => {
  return {
    date: new Date(Number(TargetDate) * 1000),
    image: getMoonImageURL(Index),
    age: Age,
    phase: Phase,
    percent: Illumination * 100,
  };
};
