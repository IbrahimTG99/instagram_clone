import "./App.css";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { icon } from "@fortawesome/fontawesome-svg-core/import.macro";
import StoryShow from "./components/StoryShow";
import StoriesListing from "./components/StoriesListing";
import RelationListing from "./components/RelationListing";
import NoPage from "./components/NoPage";
import Home from "./components/Home";

function App() {
  return (
    <body>
      <Router>
        <div className="App">
          <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
            <div className="container">
              <Link to="/" className="navbar-brand">
                <FontAwesomeIcon icon={icon({ name: "camera" })} /> | Instagram
                Clone
              </Link>
              <button
                className="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent"
                aria-expanded="false"
                aria-label="Toggle navigation"
              >
                <span className="navbar-toggler-icon"></span>
              </button>
              <div
                className="collapse navbar-collapse"
                id="navbarSupportedContent"
              >
                <ul className="navbar-nav ms-auto mb-2 mb-lg-0">
                  <li className="nav-item">
                    <Link className="nav-link active" to={"/stories"}>
                      Stories
                    </Link>
                  </li>

                  <li className="nav-item">
                    <Link className="nav-link active" to={"/relations"}>
                      Relations
                    </Link>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
        </div>

        <Routes>
          <Route path="/story/:id" element={<StoryShow />} />
          <Route path="/stories" element={<StoriesListing />} />
          <Route path="/relations" element={<RelationListing />} />
          <Route exact path="/" element={<Home />} />
          <Route path="*" element={<NoPage />} />
        </Routes>
      </Router>
    </body>
  );
}

export default App;
