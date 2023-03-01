import axios from "axios";
import { convert, MoonInfo } from "./Moon";

const getMoon = async (time: number): Promise<MoonInfo> =>
  axios
    .get(`http://api.farmsense.net/v1/moonphases/?d=${time}`)
    .then(({ data }) => data[0])
    .catch((reason) => {
      if (reason instanceof Error) {
        console.log(`${reason.name} : ${reason.message}`);
      } else {
        console.log(`Error : ${reason}`);
      }
    });

const getCurrentUnixTime = () => Math.floor(Date.now() / 1000);

const run = async () => {
  const time = getCurrentUnixTime();
  const moons = Array(7)
    .fill(0)
    .map((_, i) => time + i * 60 * 60 * 24)
    .map(async (x) => getMoon(x));
  Promise.all(moons).then((values) => {
    console.log(values.map(convert));
  });
};

run();
