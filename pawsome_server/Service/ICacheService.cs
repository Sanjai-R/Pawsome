namespace pawsome_server.Service
{
    public interface ICacheService
    {
        T GetData<T>(string key);
        bool SetData<T>(string key, T value, DateTimeOffset expirationTime);
        Object RemoveData(string key);
    }
}