using System.Net;

var builder = WebApplication.CreateBuilder(args);

//  Kestrel para escuchar en el puerto 8080
builder.WebHost.ConfigureKestrel(options =>
{
    options.Listen(IPAddress.Any, 8080); // Esto escucha en el puerto 8080 cuando ejecute en el contenedor
});

//  servicios al contenedor
builder.Services.AddControllers();

//  Swagger/OpenAPI
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

//  el pipeline de solicitudes HTTP
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

app.Run();
