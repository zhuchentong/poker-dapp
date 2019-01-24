import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as nuxtConfig from '../../nuxt.config';
import { Builder, Nuxt } from 'nuxt';
import * as express from 'express';

async function bootstrap() {
  // const app = await NestFactory.create(AppModule);
  // await app.listen(3000);

  const nuxt = await new Nuxt(nuxtConfig);
  const server = express();
  nuxtConfig.dev = !(process.env.NODE_ENV === 'production');
  if (nuxtConfig.dev) {
    new Builder(nuxt).build();
  }
  server.get(/^(?!\/?(api|doc)).+$/, (request, response) =>
    nuxt.render(request, response),
  );
  const app = await NestFactory.create(AppModule, server);

  await app.listen(3000, () => {
    return;
  });
  // app.use(nuxt.render);
}
bootstrap();
