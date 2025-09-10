// main.ts
//Importando o Método ValidationPipe
import { ValidationPipe, BadRequestException } from "@nestjs/common";

import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  //Validação Global
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true, // remove campos não definidos no DTO
      forbidNonWhitelisted: true, // erro se vier campo extra
      transform: true, // transforma tipos automaticamente
      exceptionFactory: (errors) => {
        // aqui você personaliza a resposta
        const formattedErrors = errors.map((err) => ({
          field: err.property,
          errors: Object.values(err.constraints || {}),
        }));

        return new BadRequestException({
          status: 400,
          message: "Erro de validação nos campos",
          errors: formattedErrors,
        });
      },
    })
  );

  // Habilitando CORS
  app.enableCors({
    origin: "http://localhost:3000", // URL do frontend Next.js
    methods: ["GET", "POST", "PUT", "DELETE", "PATCH"],
    credentials: true,
  });

  await app.listen(3030);
  console.log("Rodando o BackEnd (API) na porta: 3030");
}
bootstrap();
