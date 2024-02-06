using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Http;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace tourism.NewFolder1
{
    public partial class ViewFeedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["mermaid"] != null)
            {
                TextBox1.Text = (string)Session["mermaid"];
            }

        }

        protected async void Button4_Click(object sender, EventArgs e)
        {
            List<string> wordsList = Getdata();
            string[] words = wordsList.ToArray();
            words = words.Where(s => !string.IsNullOrWhiteSpace(s)).ToArray();
            string resultText = await LoadDataAsync(words);

            // ここで resultText を必要に応じて使用できます
            string[] resultArray = resultText.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            //string resultString = string.Join(" ", resultArray);
            Insertdata(resultArray);
            // GridView2を更新
            GridView2.DataBind();
        }

        private async Task<string> LoadDataAsync(string[] words)
        {
            string appId = "e6cf0009d68e02f1b430b2104b49b125a00837bb40e5e142653d0220f68e8f1a";
            string requestUrl = "https://labs.goo.ne.jp/api/morph";

            // 複数の単語をAPIに送る場合、APIへのリクエストを複数作成し、結果を集約する必要があります
            List<string> resultTextList = new List<string>();

            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.TryAddWithoutValidation("Content-Type", "application/json");

                foreach (string word in words)
                {
                    string requestData = JsonConvert.SerializeObject(new
                    {
                        app_id = appId,
                        sentence = word,
                        info_filter = "form"
                    });

                    HttpResponseMessage response = await client.PostAsync(requestUrl, new StringContent(requestData, Encoding.UTF8, "application/json"));

                    if (response.IsSuccessStatusCode)
                    {
                        string responseBody = await response.Content.ReadAsStringAsync();
                        List<List<List<string>>> wordList = ParseResponse(responseBody);

                        StringBuilder resultText = new StringBuilder();
                        foreach (var sentence in wordList)
                        {
                            foreach (var morphemeInfo in sentence)
                            {
                                foreach (var morpheme in morphemeInfo)
                                {
                                    resultText.AppendLine(FilterMorpheme(morpheme));
                                }
                            }
                        }

                        resultTextList.Add(resultText.ToString());
                    }
                    else
                    {
                        string errorMessage = await response.Content.ReadAsStringAsync();
                        resultTextList.Add($"Error: {response.StatusCode} - {response.ReasonPhrase} - {errorMessage}");
                    }
                }
            }

            // 結果を改行で連結して返す
            return string.Join(Environment.NewLine, resultTextList);
        }



        static List<List<List<string>>> ParseResponse(string responseBody)
        {
            JObject json = JObject.Parse(responseBody);
            JArray wordList = (JArray)json["word_list"];
            return wordList.ToObject<List<List<List<string>>>>();
        }



        static string FilterMorpheme(string morpheme)
        {
            if ((morpheme.Length >= 2 && ContainsOnlyKatakana(morpheme)) || ContainsKanji(morpheme))
            {
                return morpheme; // フィルタリングされた場合は空文字列を返すか、適当な値を設定してください
            }
            else
            {
                return "";
            }
        }


        static bool ContainsOnlyHiragana(string input)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(input, "^[ぁ-ん]+$");
        }

        static bool ContainsOnlyKatakana(string input)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(input, "^[ァ-ヶ]+$");
        }

        static bool ContainsKanji(string input)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(input, "[\u4E00-\u9FFF]");
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["mermaid"] = TextBox1.Text;
            Response.Redirect("InsertData.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrateData.aspx");
        }

        static void Insertdata(string[] resultArray)
        {
            //string[] textBoxLines = TextBox1.Text.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            int maxCount = resultArray.Length;
            var setting = ConfigurationManager.ConnectionStrings["Reviews"];
            using (var db = new SqlConnection(setting.ConnectionString))
            {
                var com = new SqlCommand("DELETE FROM Analysis", db);
                db.Open();
                com.ExecuteNonQuery();
                db.Close();
                for (int i = 0; i < maxCount; i++)
                {
                    var comm = new SqlCommand("INSERT INTO Analysis(bad) VALUES(@bad)", db);

                    comm.Parameters.AddWithValue("@bad", resultArray[i]);

                    db.Open();
                    comm.ExecuteNonQuery();
                    db.Close();
                }
            }
        }

        static List<string> Getdata()
        {
            List<string> bads = new List<string>();
            var setting = ConfigurationManager.ConnectionStrings["Reviews"];
            using (var db = new SqlConnection(setting.ConnectionString))
            {
                
                    var comm = new SqlCommand("SELECT bad FROM Feedback", db);

                    db.Open();
                using (var reader = comm.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        // 現在の行の "bad" カラムの値を取得
                        string badValue = reader["bad"].ToString();

                        // 配列に追加
                        bads.Add(badValue);
                    }
                }
                db.Close();
            }
            return bads;
        }
    }
}